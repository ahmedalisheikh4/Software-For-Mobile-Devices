import 'dart:io';

void main() {
  // Define the file path (assumes file.txt is in the same directory)
  String filePath = 'file.txt';

  // Try to read the file. If an error occurs, print it and exit.
  List<String> lines;
  try {
    File file = new File(filePath);
    lines = file.readAsLinesSync();
  } catch (e) {
    print("Error reading the file: $e");
    return;
  }

  // This map will store, for each line number, the list of words
  // that appear the most times on that line.
  Map<int, List<String>> highestWordsPerLine = new Map();

  // Variables to store the overall highest word frequency info.
  int globalMaxFrequency = 0;
  List<String> globalHighestWords = new List();
  List<int> globalHighestLines = new List();

  // Line counter
  int lineNumber = 0;

  // Process each line one by one.
  for (String line in lines) {
    lineNumber = lineNumber + 1;

    // Convert the line to lowercase, trim extra spaces, and split into words.
    List<String> words = line.toLowerCase().trim().split(new RegExp(r'\s+'));

    // Create a map to count how many times each word appears in this line.
    Map<String, int> countMap = new Map();
    for (String word in words) {
      // Skip empty words (if any)
      if (word == "") {
        continue;
      }
      // If the word is not already in the map, initialize its count to 0.
      if (!countMap.containsKey(word)) {
        countMap[word] = 0;
      }
      // Increase the count for this word.
      countMap[word] = countMap[word]! + 1;
    }

    // Find the highest frequency (max count) in the current line.
    int highestFreqThisLine = 0;
    for (int freq in countMap.values) {
      if (freq > highestFreqThisLine) {
        highestFreqThisLine = freq;
      }
    }

    // Create a list to store words that have the highest frequency in this line.
    List<String> highestWords = new List();
    countMap.forEach((word, freq) {
      if (freq == highestFreqThisLine) {
        highestWords.add(word);
      }
    });

    // Save the highest frequency words for this line.
    highestWordsPerLine[lineNumber] = highestWords;

    // Update the overall (global) highest frequency info.
    if (highestFreqThisLine > globalMaxFrequency) {
      // We found a new global maximum frequency.
      globalMaxFrequency = highestFreqThisLine;
      globalHighestWords = new List.from(highestWords);
      globalHighestLines = [lineNumber];
    } else if (highestFreqThisLine == globalMaxFrequency) {
      // If the frequency is equal to the current global maximum,
      // add any new words to the global list.
      for (String word in highestWords) {
        if (!globalHighestWords.contains(word)) {
          globalHighestWords.add(word);
        }
      }
      // Also record this line number.
      globalHighestLines.add(lineNumber);
    }
  }

  // Print the highest frequency words for each line.
  print("The following words have the highest word frequency per line:");
  highestWordsPerLine.forEach((lineNum, words) {
    print("Line $lineNum: $words");
  });

  // Print the overall highest frequency words and the line numbers they appear on.
  print("\nThe highest frequency words across all lines:");
  print("Words: $globalHighestWords");
  print("Appears in lines: $globalHighestLines");
}
