class FileManager
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
end

fileMod = Hash.new($vars.unit)

fileMod["import"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  $chemin.import(first)
  $vars.unit
end)

$vars.set_value("File", Value.new("struct", fileMod))
