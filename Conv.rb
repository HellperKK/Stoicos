require 'ruby2js'
#~ fichiers = Dir["Version 3/*.rb"].map{|file| File.basename(file)}
fichiers = Dir["Version 3/*.rb"]
fichiers.each do |fichier|
	contenu = Ruby2JS.convert(File.open(fichier, "r"){|i| i.read})
	File.open("VersionWeb/#{File.basename(fichier, ".rb")}.js", "w"){|i| i.write(contenu)}
end
#~ puts fichiers.to_s