class Interpreter
    @code = Hash.new
 
    def self.print
        return @code
    end
 
    def self.clear
        @code.clear
    end
 
    def self.val?( _var )
        return @code[:"#{ _var }"][:val]
    end
 
    def self.type?( _var )
       return ( @code[:"#{ _var }"].nil? ) ? nil : @code[:"#{ _var }"][:type]
    end
 
    def self.add( _var, _type, _val )
       @code[:"#{ _var }"] = { :type => "#{ _type }", :val => _val }
    end
 
    def self.include?( _var )
        return ( @code[:"#{ _var }"].nil? ) ? false : true
    end
 end
 
 
 class Handler
    @expr = nil
    def self.accessor( cmd )
       case cmd
       when 'close', 'quit', 'exit'; exit
       when 'help';
          puts "\e[32m\tThe simplest interpreter. Implemented support for data types such as byte, int, string, char, double and float.\n\tThe following commands are also provided:\n\t\tdisplay\t\tdisplays all stored identifiers\n\t\tvoid\t\tclears working space of the interpreter\n\t\tprint <>\toutputs the value of the variable passed to <>\n\t\tquit\t\tthe output of the app (similar: close, exit)\n\t\tclear\t\tclears the screen (similar: cls)\nUsage example:\nint b = 15\nint a = b - 3\e[0m"
       when 'display'; puts "\e[32m#{ Interpreter.print }\e[0m"
       when 'clear', 'cls'; system( "cls" )
       when 'void'
          system( "cls" )
          Interpreter.clear
       when /print\s\w+$/
          ( Interpreter.include? cmd.split[1] ) ?
             ( puts Interpreter.val? cmd.split[1] ) :
             ( err! 1 )
       when /^(int|byte|double|string|char|float)/
          var = cmd.split /\s*=\s*/
          if var[0].split[1] =~ /^[a-z]+$/
             ( var[1].nil? ) ? 
                ( Interpreter.add var[0].split[1], var[0].split[0], nil ) :
                ( comparer var[0].split[0], var[1] ) ?
                   ( Interpreter.add var[0].split[1], var[0].split[0], @expr ) :
                   ( err! 3 )
          else err! 4
          end
       else
          if cmd.scan /\s*=\s*/
             var = cmd.split /\s*=\s*/
             if Interpreter.include? var[0]
                ( comparer ( Interpreter.type? var[0] ), var[1] ) ? 
                   ( Interpreter.add var[0], ( Interpreter.type? var[0] ), @expr ) : 
                   ( err! 3 )
             else err! 1
             end
          else err! 0
          end
       end
    end
 
    def self.comparer( type, line )
       case type
       when 'int'
          if line =~ /^\d+$/
             @expr = line
             return true
          elsif line =~ /^\w+$/
             if Interpreter.include?( line ) and type == Interpreter.type?( line )
                @expr = Interpreter.val? line
                return true
             else return false
             end
          elsif !line.split(/\s*[+*\/\-]\s*/)[1].nil?
             if line =~ /(\d+)(\s*[+*\/\-]\s*)(\d+)/
                @expr = eval line
                return true
             elsif line =~ /(\w+|\d+)(\s*[+*\/\-]\s*)(\w+|\d+)/
                _expr = line.tr( '0-9', ' ' ).tr( '+-/*', ' ').strip.split.uniq
                _line = line
                _expr.each do | el |
                   if Interpreter.include?( el ) and type == Interpreter.type?( el )
                      _line.gsub!(el, Interpreter.val?( el ).to_s )
                   else return false
                   end
                end
                @expr = eval _line
                return true
             else return false
             end
          else return false
          end
       when 'double', 'float'
          if line =~ /^\d+\.\d+$/
             @expr = line
             return true
          elsif line =~ /^\w+$/
             if Interpreter.include?( line ) and type == Interpreter.type?( line )
                @expr = Interpreter.val? line
                return true
             else return false
             end
          elsif !line.split(/\s*[+*\/\-]\s*/)[1].nil?
             if line =~ /(\d+\.\d+)(\s*[+*\/\-]\s*)(\d+\.\d+)/
                @expr = eval line
                return true
             elsif line =~ /(\w+|\d+\.\d+)(\s*[+*\/\-]\s*)(\w+|\d+\.\d+)/
                _expr = line.tr( '0-9', ' ' ).tr( '+-/*', ' ').strip.split.uniq
                _line = line
                _expr.each do | el |
                   if Interpreter.include?(el) and type == Interpreter.type?(el)
                      _line.gsub!(el, Interpreter.val?(el).to_s)
                   else return false
                   end
                end
                begin; @expr = eval( _line ).round( 4 ); return true
                rescue Exception => e; puts "#{ e.message }"; end
             else return false
             end
          else return false
          end
       when 'char'
          if line.size == 3 and line.match?( /^'\w'/ )
             @expr = line
             return true
          elsif line =~ /^\w+$/
             if Interpreter.include?( line ) and type == Interpreter.type?( line )
                @expr = Interpreter.val? line
                return true
             else return false
             end
          else return false
          end
       when 'string'
          if line.start_with? '"' and line.end_with? '"'
             @expr = line
             return true
          elsif line =~ /^\w+$/
             if Interpreter.include?( line ) and type == Interpreter.type?( line )
                @expr = Interpreter.val? line
                return true
             else return false
             end
          else return false
          end
       when 'byte'
          if line =~ /^\d+$/
             @expr = line.to_i
             return ( @expr < 256 and @expr > 0 ) ? true : false
          elsif line =~ /^\w+$/
             if Interpreter.include?( line ) and type == Interpreter.type?( line )
                @expr = Interpreter.val? line
                return true
             else return false
             end
          elsif !line.split(/\s*[+*\/\-]\s*/)[1].nil?
             if line =~ /(\d+)(\s*[+*\/\-]\s*)(\d+)/
                @expr = eval line
                return ( @expr < 256 and @expr > 0 ) ? true : false
             elsif line =~ /(\w+|\d+)(\s*[+*\/\-]\s*)(\w+|\d+)/
                _expr = line.tr( '0-9', ' ' ).tr( '+-/*', ' ').strip.split.uniq
                _line = line
                _expr.each do | el |
                   if Interpreter.include?(el) and type == Interpreter.type?(el)
                      _line.gsub!(el, Interpreter.val?(el).to_s)
                   else return false
                   end
                end
                @expr = eval _line
                return  ( @expr < 256 and @expr > 0 ) ? true : false
             else return false
             end
          else return false
          end
       end
    end
 
    def self.err!( msg_num )
       errors = ['Unknown identifier',
               'Undefined identifier',
               'Incompatible data types',
               'Incompatible expression to data type',
               'Incorrect name of identifier']
       puts "\e[31m#{ errors[msg_num] }\e[0m"
    end
 
    private_class_method :err!, :comparer
 end
 
 
 loop do
    Handler.accessor gets.chomp
 end