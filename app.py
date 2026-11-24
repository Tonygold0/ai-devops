from flask import Flask, jsonify, request

app = Flask(__name__)

# In-memory list to store tasks (acts as our simple database for now)
tasks = []

# Route 1: Health check — confirms the app is running
@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"}), 200

# Route 2: Get all tasks
@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify({"tasks": tasks}), 200

# Route 3: Add a new task
@app.route('/tasks', methods=['POST'])
def add_task():
    data = request.get_json()
    if not data or 'title' not in data:
        return jsonify({"error": "Title is required"}), 400
    task = {
        "id": len(tasks) + 1,
        "title": data['title'],
        "done": False
    }
    tasks.append(task)
    return jsonify({"message": "Task added", "task": task}), 201

import os

if __name__ == '__main__':
    debug_mode = os.environ.get('FLASK_DEBUG', 'false').lower() == 'true'
    host = os.environ.get('FLASK_HOST', '127.0.0.1')
    port = int(os.environ.get('FLASK_PORT', '5000'))
    app.run(host=host, port=port, debug=debug_mode)

