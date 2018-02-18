package com.example.demo;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Pattern;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class LogFileController {

	@GetMapping("/")
	public String homepage() {

		return "homepage";
	}

	@PostMapping("/")
	public String processLogFile(@RequestParam("file") MultipartFile file, Model model) throws IllegalStateException, IOException {
		Map<String, Integer> occurances = new HashMap<>();// this is a map of all the viewers and the number of items they visited the page
		Scanner logFile = null;
		try {
			logFile = new Scanner(file.getInputStream());
			while (logFile.hasNextLine()) {// every line corresponds to another session (visit)
				String sentence = logFile.nextLine();
				Pattern p = Pattern.compile("\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b (\\w+) - - OBSERVED"); // the regex pattern looks for specified text and only collects what's
				// inside the (), which ends up being the name of our people
				java.util.regex.Matcher match = p.matcher(sentence); // for every math, we only retrieve the "first group" (\\w+)
				if (match.find()) {
					String nameString = match.group(1);// "first group" (\\w+)
					if (!occurances.containsKey(nameString)) { // first addition to our map
						occurances.put(nameString, new Integer(1));
					} else {
						occurances.put(nameString, new Integer(occurances.get(nameString).intValue() + 1)); // otherwise
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			logFile.close(); // we have to close the scanner regardless at the end
		}
		// this is to filter by values and then only show the top 10 users.
		Map<String, Integer> finalNames = new LinkedHashMap<>();// LinkedHashMaps are FIFO
				occurances.entrySet().stream().sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
						.limit(10).forEach(s-> finalNames.put(s.getKey(),s.getValue()));
						//.collect(Collectors.toMap(s -> StringUtils.capitalize((String) s.getKey()), s -> (Integer) s.getValue())));
		model.addAttribute("data", finalNames);
		return "homepage";
	}
}
