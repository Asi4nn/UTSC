# Author: Leo Wang

from flask import Flask, render_template, url_for, request

app = Flask(__name__)

comments = []


@app.route("/")
def root():
    return render_template("index.html", todo_list=comments)


@app.route("/add-comment")
def add_comment():
    global comments
    comments.append(request.args.get("comment-input"))

    return render_template('index.html', todo_list=comments)


@app.route("/viewMarks", methods=["POST"])
def viewMarks():
    if request.method == "POST":
        result = query_db("SELECT DISTINCT Student Name AS StudentName, ID AS StudentNumber, Assignment 1.Mark AS A1Mark, Assignment 2.Mark AS A2Mark,
                            Assignment 3.Mark AS A3Mark, Midterm Exam.Mark AS MidtermExamMark, Final Exam.Mark AS FinalExamMark
                            FROM
                                StudentInformation 
                                INNER JOIN Assignment 1
                                INNER JOIN Assignment 2
                                INNER JOIN Assignment 3
                                INNER JOIN Midterm Exam
                                INNER JOIN Final Exam
                            WHERE
                                StudentInformation.Name = ? AND StudentInformation.ID = Assignment 1.ID AND StudentInformation.ID = Assignment 2.ID AND 
                                StudentInformation.ID = Assignment 3.ID AND StudentInformation.ID = Midterm Exam.ID AND StudentInformation.ID = Final Exam.ID", [request.form[name]])
        if len(result) == 0:
            return "Sorry, the user does not exist"
        else:
            return render_template("view_results.html", ID=result[0]["StudentNumber"], A1=result[0]["A1Mark"], A2=result[0]["A2Mark"], A3=result[0]["A3Mark"], 
                                                                                        Midterm=result[0]["MidtermExamMark"], Final=result[0]["FinalExamMark"],)

    return "
    <form method="post">
        <label for="Name">Name:</label>
        <input type="text" id="Name" name="Name"/>
        <input type="submit" value="Submit"/>
    </form>"



if __name__ == '__main__':
    app.run(debug=True)
