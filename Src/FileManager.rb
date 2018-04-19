class FileManager
  attr_reader :path
  def initialize(path, file)
    @path = path
    @files = [file]
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

fileMod["import"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  $chemin.import(first)
  $vars.unit
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
