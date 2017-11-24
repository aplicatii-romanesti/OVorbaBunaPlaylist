import com.bitsinharmony.recognito.*;
import java.util.*;
import java.io.*;

public class Reco
{
	 public static void main(String[] ss)
		  {
			  try{
				   Recognito<String> reco = new Recognito<>(16000.0f);
				    VoicePrint print = reco.createVoicePrint("Remus", new File("/127068_ref.wav"));
				    VoicePrint p91 = reco.createVoicePrint("91", new File("/127091.wav"));
				    VoicePrint p92 = reco.createVoicePrint("92", new File("/127092.wav"));
				    VoicePrint p93 = reco.createVoicePrint("93", new File("/127093.wav"));
  				     List<MatchResult<String>> matches = reco.identify(new File("/73161_ref.wav"));

               for ( MatchResult<String> m : matches) {
                  System.out.println(m.getKey() + "->" + m.getLikelihoodRatio() );
               }
            // OR:
				      //MatchResult<String> match = matches.get(0);
				       //if(match.getKey().equals("Remus")) 
					        //{ System.out.println("Remus is back !!! " + match.getLikelihoodRatio() + "% positive about it..."); }
            // OR:
				      //MatchResult<String> match = matches.get(0);
					    //System.out.println("match.getKey() + "->" + match.getLikelihoodRatio() + "% positive about it..."); 
             }catch(Exception e){e.printStackTrace();}
   }
}
