module Template
  class Header
    def initialize content=nil, javascript=nil
      @content = content
      @javascript = javascript
    end

    def generate
      header = "<!DOCTYPE html>\n<html>\n"
      header += "<head>\n#{@content}\n</head>\n" if @content
      header += @javascript + "\n" if @javascript
      header += "<body>\n"
    end
  end
end
