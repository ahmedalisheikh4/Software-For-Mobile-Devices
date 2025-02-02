import 'dart:io';

main() {
  Solution obj = new Solution();
  obj.analyzeFile();
  obj.calculateLineWithHighestFrequency();
  obj.printHighestWordFrequencyAcrossLines();
}

class Solution {
  String filePath = 'C:/Users/HP/OneDrive/Desktop/K213211_SMD_A1/file.txt';

  Map<int, Map<String, int>> lineWordCount = {}; // Word count per line
  Map<int, List<String>> lineMaxWords = {}; // Highest frequency words per line
  Map<String, int> globalWordCount = {}; // Global word frequency count

  int globalMaxFreq = 0;
  List<String> globalMaxWords = [];
  List<int> globalMaxLines = [];

  void analyzeFile() {
    int lineNumber = 0;

    try {
      File file = File(filePath);
      List<String> lines = file.readAsLinesSync();

      for (String line in lines) {
        lineNumber++;
        Map<String, int> wordCount = {}; // Word count for current line

        // Split the line into words
        List<String> words = line.trim().split(RegExp(r'\s+'));
        for (String word in words) {
          wordCount[word] = (wordCount[word] ?? 0) + 1;
          globalWordCount[word] = (globalWordCount[word] ?? 0) + 1;
        }

        // Store word count for this line
        lineWordCount[lineNumber] = wordCount;
      }
    } catch (e) {
      print("Error reading the file: $e");
    }
  }

  void calculateLineWithHighestFrequency() {
    lineWordCount.forEach((lineNum, wordCount) {
      int maxFreq = wordCount.values.isEmpty
          ? 0
          : wordCount.values.reduce((a, b) => a > b ? a : b);
      List<String> maxWords = wordCount.entries
          .where((entry) => entry.value == maxFreq)
          .map((entry) => entry.key)
          .toList();

      lineMaxWords[lineNum] = maxWords;

      // Update global max frequency words
      if (maxFreq > globalMaxFreq) {
        globalMaxFreq = maxFreq;
        globalMaxWords = List.from(maxWords);
        globalMaxLines = [lineNum];
      } else if (maxFreq == globalMaxFreq) {
        for (String word in maxWords) {
          if (!globalMaxWords.contains(word)) {
            globalMaxWords.add(word);
          }
        }
        globalMaxLines.add(lineNum);
      }
    });
  }

  void printHighestWordFrequencyAcrossLines() {
    print("The following words have the highest word frequency per line:");
    lineMaxWords.forEach((lineNum, words) {
      print("$words (appears in line $lineNum)");
    });

    print("\nThe highest frequency words across all lines:");
    print("$globalMaxWords (appears in lines $globalMaxLines)");
  }
}
