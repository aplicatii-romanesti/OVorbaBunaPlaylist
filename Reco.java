import com.bitsinharmony.recognito.*;
import java.util.*;
import java.io.*;

public class Reco
{
	 public static void main(String[] folders)
		  {
			  try{

				    Recognito<String> reco = new Recognito<>(16000.0f);
				    List<VoicePrint> prints = new ArrayList<VoicePrint>();
					
					// Parsing the mixedfiles folder provided and processing all the files:
					//File folder = new File("/r/wav/");

					System.out.println("#Going to read the big folder " + folders[0]);
					System.out.println("#Going to read the small folder (usually 1 file, but sometimes can be more):" + folders[1]);
					System.out.println("#We suppose all the input files are in proper wav format. If not, for each of your files (from both dirs), do: ffmpeg -i /r/mp3/non_wav.mp3 -acodec pcm_s16le -ac 1 -ar 16000 /r/wav/correct_wav.wav ");

					File folder = new File(folders[0]);
					
					File[] listOfFiles = folder.listFiles();
					    for (int i = 0; i < listOfFiles.length; i++) {
					      if (listOfFiles[i].isFile()) {
					        System.out.println("#Processing (from big folder" + folders[0] + ") file #" + i + "/" + listOfFiles.length + " with name: " + listOfFiles[i].getName() );
							prints.add(reco.createVoicePrint(listOfFiles[i].getName(), listOfFiles[i] ));
					      }
					    }
/*
				    prints.add(reco.createVoicePrint("Remus", new File("/r/wav/73161_sample.wav")));
				    prints.add(reco.createVoicePrint("127070", new File("/r/wav/127070.wav")));
				    prints.add(reco.createVoicePrint("127091", new File("/r/wav/127091.wav")));
				    prints.add(reco.createVoicePrint("127092", new File("/r/wav/127092.wav")));
				    prints.add(reco.createVoicePrint("127093", new File("/r/wav/127093.wav")));
				    prints.add(reco.createVoicePrint("127023", new File("/r/wav/127023.wav")));
*/
				    
				    /*VoicePrint print = reco.createVoicePrint("Remus", new File("/r/wav/73161_sample.wav"));
				    VoicePrint p70 = reco.createVoicePrint("70", new File("/r/wav/127070.wav"));
				    VoicePrint p91 = reco.createVoicePrint("91", new File("/r/wav/127091.wav"));
				    VoicePrint p92 = reco.createVoicePrint("92", new File("/r/wav/127092.wav"));
				    VoicePrint p93 = reco.createVoicePrint("93", new File("/r/wav/127093.wav"));
				    VoicePrint p94 = reco.createVoicePrint("94", new File("/r/wav/127094.wav"));
				    VoicePrint p95 = reco.createVoicePrint("95", new File("/r/wav/127095.wav"));
				    VoicePrint p96 = reco.createVoicePrint("96", new File("/r/wav/127096.wav"));
				    VoicePrint p42 = reco.createVoicePrint("42", new File("/r/wav/127042.wav"));
				    VoicePrint p23 = reco.createVoicePrint("23", new File("/r/wav/127023.wav"));
				    VoicePrint p987 = reco.createVoicePrint("987", new File("/r/wav/126987.wav"));*/
  				    //List<MatchResult<String>> matches = reco.identify(new File("/r/wav/127068_sample.wav"));


					//File samplesfolder = new File("/r/wav/known_good_samples/");
					File samplesfolder = new File(folders[1]);
					
					File[] listOfSampleFiles = samplesfolder.listFiles();
					    for (int i = 0; i < listOfSampleFiles.length; i++) {
					      if (listOfSampleFiles[i].isFile()) {

					        System.out.println("#Checking the DB against this file from the small folder: " + listOfSampleFiles[i].getName() + "and these are the % -> the LikelihoodRatio");

		  				    List<MatchResult<String>> matches = reco.identify(listOfSampleFiles[i]);
			                for ( MatchResult<String> m : matches) {
			                  System.out.println(m.getKey() + "," + m.getLikelihoodRatio() );
			                }

					      }
					    }

/*  				    List<MatchResult<String>> matches = reco.identify(new File("/r/wav/73161.wav"));
	                for ( MatchResult<String> m : matches) {
	                  System.out.println(m.getKey() + "->" + m.getLikelihoodRatio() );
	                }*/

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
