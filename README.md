# Security Awareness Quiz Platform

A full-stack web application for security awareness training with separate user and admin panels. Users can take quizzes, view their results, and compete on leaderboards, while admins can manage users, questions, and view system statistics.

## Features

### User Features
- User registration and login
- Take security awareness quizzes
- View quiz results and progress
- Leaderboard to see top performers
- Dashboard with personal statistics

### Admin Features
- Admin login (uses same login form as users)
- User management (view, edit, delete users)
- Question management (create, edit, delete questions)
- System statistics and analytics
- View user quiz attempts and scores

## Tech Stack

### Backend
- **Node.js** with Express.js
- **MySQL** database
- **JWT** for authentication
- **bcrypt** for password hashing

### Frontend
- **React** with Vite
- **Tailwind CSS** for styling
- **React Router** for navigation

## Project Structure

```
Security-Awareness/
├── client/                 # React frontend
│   ├── src/
│   │   ├── admin/         # Admin panel components
│   │   ├── components/    # Shared components
│   │   ├── contexts/      # React contexts
│   │   ├── pages/         # User pages
│   │   └── utils/         # API utilities
├── server/                 # Express backend
│   ├── config/            # Database configuration
│   ├── controllers/       # Route controllers
│   ├── middleware/        # Authentication middleware
│   ├── models/            # Database models
│   └── routes/            # API routes
└── README.md
```

## Database Schema

### Users Table
```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP NULL
);
```

### Admins Table
```sql
CREATE TABLE admins (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'admin',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Quizzes Table
```sql
CREATE TABLE quizzes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  question TEXT NOT NULL,
  options JSON NOT NULL,
  correct_answer VARCHAR(255) NOT NULL,
  category VARCHAR(100) DEFAULT 'General',
  difficulty ENUM('Easy', 'Medium', 'Hard') DEFAULT 'Medium',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Quiz Attempts Table
```sql
CREATE TABLE quiz_attempts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  score DECIMAL(5,2) NOT NULL,
  total_questions INT NOT NULL,
  correct_answers INT NOT NULL,
  time_taken INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

## Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- MySQL database
- npm or yarn

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Security-Awareness
   ```

2. **Install dependencies**
   ```bash
   # Install root dependencies
   npm install
   
   # Install client dependencies
   cd client
   npm install
   
   # Install server dependencies
   cd ../server
   npm install
   ```

3. **Database Setup**
   ```bash
   # Create the database
   mysql -u root -p
   CREATE DATABASE security_awareness;
   USE security_awareness;
   
   # Run the schema (copy and paste the SQL from above)
   ```

4. **Environment Configuration**
   
   Create `.env` file in the server directory:
   ```env
   DB_HOST=localhost
   DB_USER=your_mysql_username
   DB_PASSWORD=your_mysql_password
   DB_NAME=security_awareness
   JWT_SECRET=your_jwt_secret_key
   PORT=5000
   ```

5. **Create Default Admin Account**
   ```sql
   INSERT INTO admins (username, email, password, role) 
   VALUES ('admin', 'admin@example.com', '$2b$10$YourHashedPassword', 'admin');
   ```
   
   **Default admin credentials:**
   - Email: `admin@example.com`
   - Password: `admin123`

6. **Start the Application**
   ```bash
   # From the root directory
   npm run dev
   ```
   
   This will start both the backend server (port 5000) and frontend development server (port 5173).

## API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - Unified login (users and admins)
- `GET /api/auth/profile` - Get user profile

### Quiz
- `GET /api/quiz/questions` - Get quiz questions
- `POST /api/quiz/submit` - Submit quiz attempt
- `GET /api/quiz/categories` - Get question categories
- `GET /api/quiz/attempts` - Get user attempts
- `GET /api/quiz/stats` - Get user statistics
- `GET /api/quiz/leaderboard` - Get leaderboard

### Admin (Protected)
- `GET /api/admin/stats` - Get system statistics
- `GET /api/admin/users` - Get all users
- `GET /api/admin/users/:id` - Get user by ID
- `DELETE /api/admin/users/:id` - Delete user
- `GET /api/admin/questions` - Get all questions
- `POST /api/admin/questions` - Create question
- `PUT /api/admin/questions/:id` - Update question
- `DELETE /api/admin/questions/:id` - Delete question

## Authentication System

The application uses a unified authentication system where both users and admins use the same login form. The system automatically detects the user type based on their email and redirects them to the appropriate dashboard:

- **Users** are redirected to `/dashboard`
- **Admins** are redirected to `/admin/dashboard`

The authentication middleware handles both user and admin tokens, ensuring proper access control for protected routes.

## Development

### Running in Development Mode
```bash
npm run dev
```

### Building for Production
```bash
# Build the client
cd client
npm run build

# Start the server
cd ../server
npm start
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License. 