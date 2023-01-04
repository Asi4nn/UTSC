package Part6.Q2;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternQ {
    public static void main(String[] args) {
        ArrayList<String> wordsInTweet = new ArrayList<>();
        wordsInTweet.add("#2020");
        wordsInTweet.add("#D2020");
        wordsInTweet.add("#Rio2016");

        Pattern p = Pattern.compile("^#([A-Z|a-z]+)([2-9]\\d\\d\\d)$");

        for (String word : wordsInTweet) {

            Matcher m = p.matcher(word);
            if (m.find())
                System.out.println(m.group(1) + " " + m.group(2));

        }
    }
}
