class FileManager
  def initialize(path, file)
    @path = path
    @files = [file]
  end
  def load(file)
    unless @files.include?(file)
      execute_file("#{@path}/#{file}")
      @files << file
    end
  end
  def main
    "#{@path}/#{@files[0]}"
  end
end
