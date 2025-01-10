# GitHub Workflow Demo

Below is a **step-by-step** git/GitHub workflow tutorial from Issue creation and feature branching to peer code review and merging.

> **Note**: In this demo, Jake will be the programmer and Eddy will be the reviewer.

------------------------------------------------------------------------

### 1. Create a GitHub Issue

1.  **Navigate to your repository**: `https://github.com/Analyticsphere/demo-gcp-pipeline`.
2.  **Click on “Issues”** and then “New Issue”.
3.  **Title** the Issue: “Modify `report_participant_count.Rmd` to add summary text”.
4.  **Describe** what you plan to do (e.g., “Add a summary sentence to clarify the report’s context”).
5.  Submit the new Issue. Suppose it gets **Issue #2**.

------------------------------------------------------------------------

### 2. Create a Feature Branch

From your local machine:

``` bash
# Ensure you're on main and up-to-date
git checkout main
git pull origin main

# Create and switch to a new feature branch
git checkout -b feature/issue-1-add-summary
```

> **Tip**: Branch names often reference the Issue number.

------------------------------------------------------------------------

### 3. Modify File & Commit Changes

Assume you edit `report_participant_count.Rmd`.
For instance, add a sentence after the participant count line:

`The total number of participants ... is r data$total_verified_participants.` **Add**: `This is the current verified participant count in the Connect system.`

Then stage and commit:

``` bash
git add report_participant_count.Rmd
git commit -m "Add summary sentence to participant count report (#2)"
```

------------------------------------------------------------------------

### 4. Push Your Branch & Open a Pull Request

``` bash
# Push the branch to GitHub
git push -u origin feature/issue-2-add-summary
```
> **Note**: The -u (or --set-upstream) flag links your local branch to the newly created remote branch. After this, the remote branch (named feature/issue-2-add-summary) appears in your GitHub repository.

1.  **On GitHub**, find the prompt to create a PR from your new branch.

2.  **Title** the PR: “Add summary sentence to the participant count report (#1)”

3.  In the **description**, reference the issue:

    `This PR resolves #2 by adding a summary sentence to clarify the participant count.`

    (Using keywords like “Closes #2” will automatically close the issue upon merge.)

4.  **Create** the Pull Request.

------------------------------------------------------------------------

### 5. Peer Code Review

1.  **Open or Access the Pull Request**
    -   Assign reviewers and confirm the PR is ready for review.
2.  **Reviewers Check the Changes**
    -   Examine the code diffs, commit messages, and discussion in the PR thread.
3.  **Discuss & Provide Feedback**
    -   Leave comments, questions, or suggestions inline.
    -   Request modifications if needed.
4.  **Author Responds & Updates**
    -   The PR author addresses comments and pushes changes to the same branch.
5.  **Approve or Merge**
    -   Once any concerns are resolved, approve and merge.
    -   Merging will automatically close linked issues (e.g., “Closes #1”).

------------------------------------------------------------------------

### 6. Clean Up

``` bash
# Switch back to main and pull the latest changes
git checkout main
git pull origin main

# (Optional) Delete the local feature branch
git branch -d feature/issue-2-add-summary

# (Optional) Delete the remote feature branch
git push origin --delete feature/issue-2-add-summary
```

------------------------------------------------------------------------

### Summary of Best Practices

1.  **Reference the Issue** in your branch name, commits, and PR description (e.g., “(#2)” or “Closes #2”).
2.  **Small, atomic commits** with clear messages help maintain a clean history.
3.  **Peer Review** is crucial for code quality and knowledge sharing.
4.  **Merge Strategy**: Decide whether to squash commits or merge them all. Consistency is key.
5.  **Documentation**: Keep your team’s workflow steps accessible (e.g., team wiki or README).

##### PR *Reviewer* Responsibilities & Best Practices:

-   **Be Clear & Constructive**: Suggest improvements, highlight good practices, and focus on clear logic.

-   **Ask Questions**: If something is unclear, request more details.

-   **Ensure Consistency**: Check naming conventions, coding style, and sufficient documentation.

-   **Check for Quality**: Identify potential bugs, maintainability issues, or performance concerns.

-   **Approve or Request Changes**: Approve only when confident the code meets standards.

##### PR *Author* Responsibilities & Best Practices:

-   **Respond Promptly**: Clarify any questions and implement changes as needed.

-   **Keep Discussion Open**: Work with reviewers to find the best solutions.

-   **Update the PR**: Push changes to the same branch so the PR updates automatically.

##### Code Review Checklist

-   [ ] Is any sensitive information present? (Programmers should check this before making commits!)
-   [ ] Is the code readable? Comments used?
-   [ ] Is a consistent naming scheme used?
-   [ ] Is the code written in a modular way?
-   [ ] Is the code appropriately parameterized or are values that may change hard-coded (e.g., file paths)?
-   [ ] Does the code appear to do what it is intended to do?
-   [ ] ...

> **Note**: Brainstorm with team about additions or modifications to this list to get buy in.
