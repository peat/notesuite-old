namespace :export do

  desc "Sticks the tables into MongoDB"
  task :mongo => :environment do
    require 'mongo'

    def id_for_legacy( id, collection )
      return nil if id.blank?

      begin
        collection.find_one( 'legacy_id' => id )['_id']
      rescue
        puts "Could not find legacy_id '#{id}' in collection '#{collection.name}'"
      end
    end

    def from_date( d )
      return nil if d.blank?
      d.to_time.utc
    end

    db = Mongo::Connection.new.db('notesuite')

    puts Time.now

    # Regions
    db.drop_collection('regions')
    regions = db.collection('regions')
    Region.all.each do |r|
      regions.insert({
        :legacy_id    => r.id,
        :name         => r.name,
        :native_name  => r.native_name,
        :parent_id    => r.parent_id,
        :ancestry     => r.ancestry
      })
    end

    # fix up the parent_ids
    regions.find.each do |r|
      regions.find( 'parent_id' => r['legacy_id'] ).each do |doc| 
        doc['parent_id'] = r['_id']
        regions.update( {'_id' => doc['_id']} , doc )
      end
    end

    # Authorities
    db.drop_collection('authorities')
    authorities = db.collection('authorities')
    Authority.all.each do |a|
      authorities.insert({
        :legacy_id  => a.id,
        :name       => a.name,
        :region_id  => id_for_legacy( a.region_id, regions )
      })
    end

    # Grades
    db.drop_collection('grades')
    grades = db.collection('grades')
    Grade.all.each do |g|
      grades.insert({
        :legacy_id    => g.id,
        :name         => g.name,
        :full_name    => g.full_name,
        :description  => g.description,
        :rank         => g.rank
      })
    end

    # Currencies
    db.drop_collection('currencies')
    currencies = db.collection('currencies')
    Currency.all.each do |c|
      currencies.insert({
        :legacy_id    => c.id,
        :unit         => c.unit,
        :region_id    => id_for_legacy( c.region_id, regions ),
        :symbol       => c.symbol,
        :authority_id => id_for_legacy( c.authority_id, authorities )
      })
    end

    # Printers
    db.drop_collection('printers')
    printers = db.collection('printers')
    Printer.all.each do |p|
      printers.insert({
        :legacy_id  => p.id,
        :name       => p.name,
        :region_id  => id_for_legacy( p.region_id, regions )
      })
    end

    # Masters
    db.drop_collection('masters')
    masters = db.collection('masters')
    Master.all.each do |m|
      masters.insert({
        :legacy_id    => m.id,
        :currency_id  => id_for_legacy( m.currency_id, currencies ),
        :code         => m.code,
        :denomination => (m.denomination * 100).to_i,
        :description  => m.description,
        :overprint    => { 
          :currency_id  => id_for_legacy( m.overprint_currency_id, currencies ),
          :denomination => m.overprint_denomination
        },
        :issued_on    => from_date( m.issued_on ),
        :printed_on   => from_date( m.printed_on ),
        :withdrawn_on => from_date( m.withdrawn_on ),
        :lapsed_on    => from_date( m.lapsed_on ),
        :printer_id   => id_for_legacy( m.printer_id, printers ),
        :created_at   => m.created_at.utc,
        :updated_at   => m.updated_at.utc
      })
    end

    # Notes
    db.drop_collection('notes')
    notes = db.collection('notes')
    Note.all.each do |n|
      notes.insert({
        :legacy_id    => n.id,
        :master_id    => id_for_legacy( n.master_id, masters ),
        :grade_id     => id_for_legacy( n.grade_id, grades ),
        :serial       => n.serial,
        :description  => n.description,
        :printed_on   => from_date( n.printed_on ),
        :replacement  => n.replacement,
        :created_at   => n.created_at.utc,
        :updated_at   => n.updated_at.utc
      })
    end

    # remove legacy ids
    [ regions, authorities, grades, currencies, printers, masters, notes ].each do |col|
      col.find.each do |record|
        record.delete('legacy_id')
        col.update( {'_id' => record['_id']}, record )
      end
    end

    puts Time.now

  end

end
