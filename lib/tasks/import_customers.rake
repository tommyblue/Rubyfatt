require 'vpim/vcard'
namespace :customers do
  desc "Import customers throught VCF in tmp/vcf"
  task :import => :environment do
    class String
      alias_method :each, :each_line
    end
    
    print "Which is the ID of the user to whom assign customers?"
    user_id = $stdin.gets.to_i
    if user = User.find(user_id)
      path = "#{Rails.root}/tmp/vcf/*.vcf"
      Dir[path].each do |f| 
        vcf_file = File.new("#{f}" , 'r')
        vcard = Vpim::Vcard.decode(vcf_file).first

        user.customers.create(
          :title => vcard.name.fullname,
          :name => vcard.name.given,
          :surname => vcard.name.family,
          :address => vcard.address.street,
          :zip_code => vcard.address.postalcode,
          :town => vcard.address.locality,
          :province => vcard.address.region
        )
      end
    else
      puts "Can't find specified user"
    end
  end
end