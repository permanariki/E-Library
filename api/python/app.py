from flask import Flask, request, json, session, make_response
from flask_sqlalchemy import SQLAlchemy
from flask_restful import marshal, fields
from flask_cors import CORS, cross_origin
import jwt
import os


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:Scada123@localhost:5432/eLibrary'
app.config['SECRET_KEY'] = os.urandom(24)
CORS(app, support_credentials=True)
db = SQLAlchemy(app)
jwtSecretKey = "secretkey"

##############
## DATABASE ##
##############

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50))
    status = db.Column(db.String())
    password = db.Column(db.String())
    phone_number = db.Column(db.Integer())
    address = db.Column(db.String())

class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String())
    number = db.Column(db.Integer())
    published = db.Column(db.String())
    author = db.Column(db.String())

class BookHistory(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    lend_date = db.Column(db.String())
    return_date = db.Column(db.String())
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'))



########################
####### BACKEND ########
########################
@app.route('/login', methods=['POST'])
def login():
    if request.method =='POST':
        data = request.get_json()
        username = data.get('username')
        password = data.get('password')

        userDB = User.query.filter_by(username=username).first()

        if userDB.status == "admin":
            payload = {
                "username" : userDB.username
            }
            encoded = jwt.encode(payload, jwtSecretKey, algorithm='HS256')
            return encoded, 201
        else:
            return "user doesn't exist", 405
    else:
        return "Method not allowed", 405

# untuk memeriksa apakah sudah login
@app.route('/sessionCheck')
def checkSession():
    decoded = jwt.decode(request.headers["Authorization"], jwtSecretKey, algorithms=['HS256'])
    username = decoded['username']
    if username:
        return "already login",200
    else:
        return "please login",405

# untuk menambah buku
@app.route('/inputNewBook', methods=['POST'])
def inputNewBook():
    data = request.get_json()
    decoded = jwt.decode(request.headers["Authorization"], jwtSecretKey, algorithm='HS256')
    userDB = User.query.filter_by(username = decoded["username"]).first()
    
    if userDB:
        newBook = Book(
            title = data.get('title'),
            number = data.get('number'),
            published = data.get('published'),
            author = data.get('author')
        )
        db.session.add(newBook)
        db.session.commit()
        return "Book list already updated", 201
    else:
        return "Please login"

# untuk menambah data peminjaman buku
@app.route('/inputLendBook', methods=['POST'])
def inputLendBook():
    data = request.get_json()
    decoded = jwt.decode(request.headers["Authorization"], jwtSecretKey, algorithm='HS256')
    userDB = User.query.filter_by(username = decoded["username"]).first()
    
    if userDB:
        newLend = BookHistory(
            lend_date = data.get('lend_date'),
            return_date = data.get('return_date'),
            user_id = data.get('user_id'),
            book_id = data.get('book-id')
        )
        db.session.add(newLend)
        db.session.commit()
        return "success to lend a book", 201
    else:
        return "Please login", 405

# untuk meliahat semua daftar buku
@app.route('/getAllBook')
def getAllBook():
    decoded = jwt.decode(request.headers["Authorization"], jwtSecretKey, algorithm='HS256')
    userDB = User.query.filter_by(username = decoded["username"]).first()
    bookDB = Book.query.all()

    if userDB:
        book_json = {
            "title" : fields.String,
            "number" : fields.String,
            "published" : fields.String,
            "author" : fields.String
        }
        
        all_book = marshal(bookDB,book_json)

        all_book_json = json.dumps(all_book)
        return all_book_json, 200
    else:
        return "please login", 405




# untuk melihat detail dari sebuah buku
@app.route('/bookDetail')
def bookDetail():
    data = request.get_json()
    bookTitle = data.get('title')
    decoded = jwt.decode(request.headers["Authorization"], jwtSecretKey, algorithm='HS256')
    userDB = User.query.filter_by(username = decoded["username"]).first()
    bookDB = Book.query.filter_by(title = bookTitle).first()
    bookHistoryDB = BookHistory.query.filter_by(book_id = bookDB.id).all()

    if userDB:
        detail = []
        histories = []
        lendHistories = []

        bookHistory_json = {
            "lend_date" : fields.String,
            "return_date" : fields.String,
            "user_id" : fields.String,
            "book_id" : fields.String
        }

        all_history = marshal(bookHistoryDB, bookHistory_json)
        histories.append(all_history)

        for idx in len(histories):
            dbUser = User.query.filter_by(id=histories[idx]["user_id"]).first()
            history_json = {
                "name" : dbUser.username,
                "lend_date" : histories[idx]["lend_date"],
                "return_date" : histories[idx]["return_date"]
            }
            lendHistories.append(history_json)

        json_format = {
            "book_title" : bookDB.title,
            "book_number" : bookDB.number,
            "book_published" : bookDB.published,
            "author" : bookDB.author
        }

        detail.append(json_format)
        detail.append(lendHistories)

        detail_json = json.dumps(detail)
        return detail_json, 200
    else:
        return "please login", 405
       


if __name__ == '__main__':
    app.run(debug=True, host=os.getenv("HOST"), port=os.getenv("PORT"))