module Template
  class Header
    def initialize content=nil
      @content = content
    end

    def generate
      header = "<!DOCTYPE html>\n<html>\n"
      header += "<head>\n#{@content}\n</head>\n" if @content
      header += "<body>\n"
    end
  end
end
