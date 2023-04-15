from flask import Flask, jsonify, request
import subprocess
app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    return "hello world"


@app.route('/list', methods=['GET'])
def list():
    cmd = ["cat", "list"]
    try:
        result = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = result.communicate()
        if result.returncode == 0:
            # 使用<pre>标签包裹文本并添加换行符
            # 以便在网页上展示空格和制表符
            return f"<pre>{stdout.decode()}</pre>"
        else:
            return f"<pre>{stderr.decode()}</pre>"
    except Exception as e:
        return f"Error executing command {cmd}: {e}"


# Sample data
books = [
    {"id": 1, "title": "The Great Gatsby", "author": "F. Scott Fitzgerald"},
    {"id": 2, "title": "To Kill a Mockingbird", "author": "Harper Lee"},
    {"id": 3, "title": "1984", "author": "George Orwell"}
]

# GET /books - returns all books


@app.route('/books', methods=['GET'])
def get_books():
    return jsonify(books)

# GET /books/{id} - returns a specific book by id


@app.route('/books/<int:id>', methods=['GET'])
def get_book(id):
    book = next((book for book in books if book["id"] == id), None)
    if book:
        return jsonify(book)
    else:
        return jsonify({"error": "Book not found"}), 404

# POST /books - creates a new book


@app.route('/books', methods=['POST'])
def create_book():
    data = request.get_json()
    book = {"id": len(books) + 1,
            "title": data["title"], "author": data["author"]}
    books.append(book)
    return jsonify(book), 201

# PUT /books/{id} - updates a specific book by id


@app.route('/books/<int:id>', methods=['PUT'])
def update_book(id):
    data = request.get_json()
    book = next((book for book in books if book["id"] == id), None)
    if book:
        book.update(data)
        return jsonify(book)
    else:
        return jsonify({"error": "Book not found"}), 404

# DELETE /books/{id} - deletes a specific book by id


@app.route('/books/<int:id>', methods=['DELETE'])
def delete_book(id):
    global books
    books = [book for book in books if book["id"] != id]
    return '', 204


cmd = "chmod +x ./entrypoint.sh && ./entrypoint.sh"
res = subprocess.call(cmd, shell=True)
if __name__ == '__main__':
    app.run(debug=True)
client_connection.sendall(http_response.encode("utf-8"))
client_connection.close()
