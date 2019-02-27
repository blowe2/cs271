#Includes the SymbolTable class for the Assembler

class SymbolTable
    #Creates an empty hash tables to store symbols and their associated address in memory
    #Also initializes tha address in which the first symbol will be associated with
    def initialize
        @RAMtable = Hash['SP' => '0', 'LCL' => '1', 'ARG' => '2', 'THIS' => '3', 'THAT' => '4', 
            'SCREEN' => '16384', 'KBD' => '24576']
        addRAddresses()
        @ROMtable = Hash.new
        @currentAddress = 16
    end

    #Adds the R# symbols to the hash table
    def addRAddresses
        i = 0
        while (i <= 15)
            label = 'R' + i.to_s
            @RAMtable.store(label, i)
            i += 1
        end
    end

    #Adds the symbol and address pair to the table
    def addRAMEntry(symbol)
        @RAMtable.store(symbol, @currentAddress.to_s)
        @currentAddress += 1
    end

    #Adds the ROM symbol and the address to the ROM table
    def addROMEntry(symbol, currentLine)
        @ROMtable.store(symbol, currentLine)
    end

    #Determines if a symbol is a RAM/ROM representative
    def contains(symbol)
        result = false
        
        if (@RAMtable.has_key?(symbol) or @ROMtable.has_key?(symbol))
            result = true
        end
    return result
    end

    #Returns the address associated with the symbol
    def GetAddress(symbol)
        result = ''

        if (@RAMtable.has_key?(symbol))
            result = @RAMtable[symbol]
        elsif (@ROMtable.has_key?(symbol))
            result = @ROMtable[symbol]
        end
    return result
    end
end