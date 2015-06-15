package mx.amib.sistemas.utils

/**
 * Created by Gabriel on 12/06/2015.
 */
class StringUtils {
    private static final int LEFT = 0;
    private static final int RIGHT = 1;

    public static String padLeft(char padFiller, String originalStr, int maxsize){
        return StringUtils.pad(StringUtils.LEFT, padFiller, originalStr, maxsize)
    }

    private static String pad(int filler, char padFiller, String originalStr, int maxsize){
        String result = null
        int charsToInsert = maxsize - originalStr.length()

        if(charsToInsert <= 0)
            result = originalStr
        else{
            StringBuilder sb = new StringBuilder()
            if(filler == StringUtils.RIGHT){
                sb.append(originalStr)
                for(int i = 0; i < charsToInsert; i++){
                    sb.append(padFiller)
                }
            }
            else if(filler == StringUtils.LEFT){
                for(int i = 0; i < charsToInsert; i++){
                    sb.append(padFiller)
                }
                sb.append(originalStr)
            }
            result = sb.toString()
        }

        return originalStr
    }
}
