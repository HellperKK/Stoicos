class FileManager
  attr_reader :path
  def initialize(path, file)
    @path = path
    @files = [file]
  end
  def require(file)
    unless @files.include?(file)
      begin
        requireBis("#{@path}/#{file}")
        @files << file
      rescue

      end
    end
  end
  def import(file)
    unless @files.include?(file)
      begin
        execute_file("#{@path}/#{file}")
        @files << file
      rescue

      end
    end
  end
  def main
    "#{@path}/#{@files[0]}"
  end
  def relative(file)
    "#{@path}/#{file}"
  end
end

fileMod = Hash.new($vars.unit)

fileMod["require"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  requireBis(first)
  $vars.unit
end)

fileMod["import"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  $chemin.import(first)
  $vars.unit
end)

fileMod["import_module"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  $vars.add_stack
  $chemin.import(first)
  resultat = $vars.get_stack
	$vars.remove_stack
  Value.new("struct", resultat)
end)

fileMod["read"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  begin
    Value.new("string", File.open($chemin.relative(first), "r"){|i| i.read})
  rescue
    $vars.unit
  end
end)

fileMod["write"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("string").value
  File.open($chemin.relative(first), "w"){|i| i.write(second)}
  $vars.unit
end)

$vars.set_value("File", Value.new("struct", fileMod))
