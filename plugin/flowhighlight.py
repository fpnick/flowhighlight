import re 
def find_flow(buffer_contents):
    level = 0
    for i in range(len(buffer_contents)):
         
        string = buffer_contents[i]
        if ( re.match('[ ]*if .* then.*',string,re.IGNORECASE) ):
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level)
            level = level+1
        
        if ( re.match('[ ]*endif',string,re.IGNORECASE) ):
            level = level-1
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level)

    return buffer_contents

