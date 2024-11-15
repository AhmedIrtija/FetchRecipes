# FetchRecipes
## Steps to Run the Code
1. Clone this repository to your latest version of Xcode.
2. Click *File* and press *Add Package Dependencies*.
3. Search for "https://github.com/onevcat/Kingfisher" and add the latest version of the KingFisher package.
4. Open the *RecipeView* file and change the variable titled `JSONUrl` to the corresponding URL for the JSON file. If not, keep the variable as is to query the provided URL.
5. Run the code on a simulator or your iPhone to view the app.

## Features
- Once the app loads, if there’s an error, a warning image will appear with details about the error.
- If there are no errors, you will see a page with a list of recipes.
- You can refresh the page by scrolling up, which will randomize the recipes.
- You can sort recipes alphabetically in ascending or descending order, or by the type of cuisine.
- If recipes have a source link (indicated by a blue-colored name), pressing the name will open the corresponding link in your browser.
- If recipes have a play button next to the name, pressing it will take you to a YouTube video of the recipe.
- You can scroll up and down to browse all the recipes.

## Focus Areas
I prioritized the user experience by creating a smooth user interface and ensuring low latency. I focused on this because the purpose of any app is how users feel when using it, as they are the main audience. While ensuring a smooth UI, I kept the code scalable and clean, adding adequate comments so anyone reading it would understand its functionality.

## Time Spent
I worked a total of 7 hours on this project. Most of the time was spent ensuring a beautiful design and adding features to improve the UI/UX. Approximately 2.5 hours were spent completing the main functionality, which I worked on first. The remaining 4.5 hours were dedicated to adding and enhancing features and designs.

## Trade-offs and Decisions
The main trade-off I made was spending more time than needed to ensure perfection. This decision was worthwhile because there was no time limit, so I wanted to take full advantage of this to make everything work well.

## Weakest Part of the Project
The weakest part of the project is the unit testing, as the entire app only uses one function. For this, I only needed to check if it was reading the JSON correctly. Since UI testing was not necessary and to save time, I did not include it, so there could be some UI issues.

## External Code and Dependencies
I used one dependency to enhance the app: the KingFisher package. This package helps reduce network usage by caching images on disk and allowing easy access. This was very helpful because my app calls the API endpoint whenever the user refreshes the page, which could have led to high bandwidth consumption. However, with this package, it saves time and reduces latency by caching images locally.

## Additional Information
One major lesson I learned from this project was unit testing. Many projects or LeetCode-style coding challenges do not provide room for learning new skills. I am glad to have worked on this project because now I know how to unit test each function in a SwiftUI project, which will be useful for future apps and self-projects.

