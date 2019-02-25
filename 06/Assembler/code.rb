#Includes the code class for the assembler

class Code
    #Returns the binary code for the dest mnemonic
    def dest(_dest)
        d1 = '0'
        d2 = '0'
        d3 = '0'

        if (_dest.include?"M")
            d3 = '1'
        end
        
        if (_dest.include?"D")
            d2 = '1'
        end

        if (_dest.include?"A")
            d1 = '1'
        end
    return d1 + d2 + d3
    end

    #Returns the binary code for the comp mnemonic
    def comp(_comp)
        a = '0'
        c1 = '0'
        c2 = '0'
        c3 = '0'
        c4 = '0'
        c5 = '0'
        c6 = '0'

        if (_comp.include?'M')
            a = '1'
        end

        if (_comp == '0')
            c1 = '1'
            c3 = '1'
            c5 = '1'
        elsif (_comp == '1')
            c1 = '1'
            c2 = '1'
            c3 = '1'
            c4 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == '-1')
            c1 = '1'
            c2 = '1'
            c3 = '1'
            c5 = '1'
        elsif (_comp == 'D')
            c3 = '1'
            c4 = '1'
        elsif (_comp == 'A' or _comp == 'M')
            c1 = '1'
            c2 = '1'
        elsif (_comp == '!D')
            c3 = '1'
            c4 = '1'
            c6 = '1'
        elsif (_comp == '!A' or _comp == '!M')
            c1 = '1'
            c2 = '1'
            c6 = '1'
        elsif (_comp == '-D')
            c3 = '1'
            c4 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == '-A' or _comp == '-M')
            c1 = '1'
            c2 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == 'D+1')
            c2 = '1'
            c3 = '1'
            c4 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == 'A+1' or _comp == 'M+1')
            c1 = '1'
            c2 = '1'
            c4 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == 'D-1')
            c3 = '1'
            c4 = '1'
            c5 = '1'
        elsif (_comp == 'A-1' or _comp == 'M-1')
            c1 = '1'
            c2 = '1'
            c5 = '1'
        elsif (_comp == 'D+A' or _comp == 'D+M')
            c5 = '1'
        elsif (_comp == 'D-A' or _comp == 'D-M')
            c2 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == 'A-D' or _comp == 'M-D')
            c4 = '1'
            c5 = '1'
            c6 = '1'
        elsif (_comp == 'D&A' or _comp == 'D&M')
            #Do nothing
        elsif (_comp == 'D|A' or _comp == 'D|M')
            c2 = '1'
            c4 = '1'
            c6 = '1'
        else
            raise 'invalid syntax'
        end
    return a + c1 + c2 + c3 + c4 + c5 + c6
    end

    #Returns the binary code for the jump mnemonic
    def jump(_jump)
        j1 = '0'
        j2 = '0'
        j3 = '0'

        if (_jump == 'null')
            #Do nothing
        elsif (_jump == 'JGT')
            j3 = '1'
        elsif (_jump == 'JEQ')
            j2 = '1'
        elsif (_jump == 'JGE')
            j2 = '1'
            j3 = '1'
        elsif (_jump == 'JLT')
            j1 = '1'
        elsif (_jump == 'JNE')
            j1 = '1'
            j3 = '1'
        elsif (_jump == 'JLE')
            j1 = '1'
            j2 = '1'
        elsif (_jump == 'JMP')
            j1 = '1'
            j2 = '1'
            j3 = '1'
        else
            raise 'invalid syntax'
        end
    return j1 + j2 + j3
    end

    def toBinary(val)
        result = val.to_s(2)
        while (result.length != 16)
            result = '0' + result
        end
    return result
    end
end