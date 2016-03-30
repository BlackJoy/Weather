package 爬虫测试;



import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
 


public class XmlUtils {
	
	
	public static void main(String[] args) throws UnsupportedEncodingException {
        String s = "����";
        
        List<String> citylist = toDatabase.findAllCity();
        
        System.out.println(citylist);
        
    }
    public static String string2Unicode(String string) {
          
        StringBuffer unicode = new StringBuffer();
      
        for (int i = 0; i < string.length(); i++) {
      
            // ȡ��ÿһ���ַ�
            char c = string.charAt(i);
      
            // ת��Ϊunicode
            unicode.append("\\u" + Integer.toHexString(c));
        }
      
        return unicode.toString();
    }
}