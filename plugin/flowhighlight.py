import re 
def find_flow(buffer_contents):
    """ Uses regex to find ifs and corresponding elses and endifs
    Marks them with a tag that can be used by vi later.
    """
    level = 0
    max_level = 0
    for i in range(len(buffer_contents)):
         
        string = buffer_contents[i]
        if ( re.match('[ ]*if .* then.*',string,re.IGNORECASE) ):
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level)
            level = level+1
            if max_level < level:
                max_level = level
        
        if ( re.match('[ ]*else',string,re.IGNORECASE) ):
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level-1)

        if ( re.match('[ ]*else if .* then',string,re.IGNORECASE) ):
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level-1)
        
        if ( re.match('[ ]*endif',string,re.IGNORECASE) ):
            level = level-1
            buffer_contents[i] = string + '!flowhighlightlevel' + str(level)

    buffer_contents.append(str(max_level-1))
    return buffer_contents

