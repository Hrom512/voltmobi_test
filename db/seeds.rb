user = User.create!(email: 'user@example.com', password: '12345678')

Task.create!(user: user, name: 'Task 1', description: 'Task 1 description', state: 'new')
Task.create!(user: user, name: 'Task 2', description: 'Task 2 description', state: 'started')
Task.create!(user: user, name: 'Task 3', description: 'Task 3 description', state: 'finished')
