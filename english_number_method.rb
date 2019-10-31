# By Chris Pine
def englishNumber number
    if number == 0
        return "zero"
    end

    numString = ""
    onesPlace = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    tensPlace = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    teenagers = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
# My additions
    illions = ["m", "b", "tr", "quadr", "quint", "sext", "sept", "oct", "non", "dec", "undec", "tredec", "quattuordec", "quindec", "sexdec", "septendec", "octodec", "novemdec", "vigint", "cent"]

    left = number
    if number / 1000000 > 0
        while left > 1000000
        place = left
        times = 0
            while place.to_s.length > 3
                place = place / 1000
                times += 1
            end
            write = left / 1000**times
            left = left - write * 1000**times
            zeros = englishNumber write
            numString = numString + zeros + " #{illions[times-2]}illion"
            if left > 0
                numString = numString + " "
            end
        end
    end

    write = left / 1000
    left = left - write * 1000
    if write > 0
        thousands = englishNumber write
        numString = numString + thousands + " thousand"
        if left > 0
            numString = numString + " "
        end
    end
# Back to Chris
    write = left / 100
    left = left - write * 100

    if write > 0
        hundreds = englishNumber write
        numString = numString + hundreds + " hundred"
        if left > 0
            numString = numString + " "
        end
    end

    write = left / 10
    left = left - write * 10

    if write > 0
        if ((write == 1) and (left > 0))
            numString = numString + teenagers[left-1]
            left = 0
        else 
            numString = numString + tensPlace[write-1]
        end

        if left > 0
            numString = numString + "-"
        end
    end

    write = left
    left = 0

    if write > 0
        numString = numString + onesPlace[write-1]
    end

    numString
end
