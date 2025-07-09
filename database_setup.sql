-- Security Awareness Quiz Database Setup
-- Run this script in your MySQL database

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS security_awareness;
USE security_awareness;

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'user'
);

-- Quiz questions table
CREATE TABLE IF NOT EXISTS quizzes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  question TEXT NOT NULL,
  options JSON NOT NULL,
  correct_answer VARCHAR(255) NOT NULL,
  category VARCHAR(100) DEFAULT 'General',
  difficulty ENUM('Easy', 'Medium', 'Hard') DEFAULT 'Medium',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quiz attempts table
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  score DECIMAL(5,2) NOT NULL,
  total_questions INT NOT NULL,
  correct_answers INT NOT NULL,
  time_taken INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Levels table
CREATE TABLE IF NOT EXISTS levels (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Insert standard levels
INSERT INTO levels (name) VALUES ('Easy'), ('Medium'), ('Hard'), ('Expert')
    ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Update quiz_questions table to add level_id foreign key
ALTER TABLE quiz_questions 
    ADD COLUMN level_id INT NULL,
    ADD CONSTRAINT fk_level_id FOREIGN KEY (level_id) REFERENCES levels(id);

-- Optionally, keep difficulty string for backward compatibility
-- ALTER TABLE quiz_questions ADD COLUMN difficulty VARCHAR(50);

-- Example: Insert a question with level_id
INSERT INTO quiz_questions (question, options, correct_answer, category, level_id, created_at)
VALUES (
  'What is a firewall?',
  '["A security barrier", "A type of malware", "A password", "A backup device"]',
  'A security barrier',
  'Network',
  (SELECT id FROM levels WHERE name = 'Easy'),
  NOW()
);

-- Add email verification columns to users table
ALTER TABLE users
  ADD COLUMN verified BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN verification_token VARCHAR(255);



-- Insert default admin account
-- Password: admin123 (hashed with bcrypt)
INSERT INTO users (username, email, password, role) VALUES 
('admin', 'admin@example.com', '$2a$10$wqQw6Qw6Qw6Qw6Qw6Qw6QeQw6Qw6Qw6Qw6Qw6Qw6Qw6Qw6Qw6Qw6', 'admin')
ON DUPLICATE KEY UPDATE role = 'admin';

-- Insert sample quiz questions
INSERT INTO quizzes (question, options, correct_answer, category, difficulty) VALUES
(
  'What is the best practice for creating a strong password?',
  '["Use personal information like your name", "Use a mix of uppercase, lowercase, numbers, and symbols", "Use only lowercase letters", "Use your birthdate"]',
  'Use a mix of uppercase, lowercase, numbers, and symbols',
  'Password Security',
  'Easy'
),
(
  'What should you do if you receive a suspicious email asking for your password?',
  '["Reply with your password", "Forward it to your IT department", "Click on any links in the email", "Ignore it completely"]',
  'Forward it to your IT department',
  'Phishing Awareness',
  'Medium'
),
(
  'What is two-factor authentication (2FA)?',
  '["Using two different passwords", "A second layer of security beyond just a password", "Having two email accounts", "Using two different browsers"]',
  'A second layer of security beyond just a password',
  'Authentication',
  'Easy'
),
(
  'What is a common sign of a phishing email?',
  '["Professional formatting", "Urgent requests for personal information", "Clear company branding", "Proper grammar and spelling"]',
  'Urgent requests for personal information',
  'Phishing Awareness',
  'Medium'
),
(
  'What should you do before clicking on a link in an email?',
  '["Click immediately if it looks interesting", "Hover over the link to see the actual URL", "Forward to all your contacts", "Reply to the sender"]',
  'Hover over the link to see the actual URL',
  'Email Security',
  'Easy'
),
(
  'What is the purpose of a firewall?',
  '["To speed up internet connection", "To block unauthorized access to a network", "To store passwords securely", "To encrypt emails"]',
  'To block unauthorized access to a network',
  'Network Security',
  'Medium'
),
(
  'What is social engineering?',
  '["A type of computer virus", "Manipulating people to gain unauthorized access", "A programming language", "A security software"]',
  'Manipulating people to gain unauthorized access',
  'Social Engineering',
  'Hard'
),
(
  'What should you do if you suspect your account has been compromised?',
  '["Ignore it and hope it goes away", "Change your password immediately", "Share the incident on social media", "Wait for someone to contact you"]',
  'Change your password immediately',
  'Account Security',
  'Easy'
),
(
  'What is encryption?',
  '["A type of computer virus", "Converting data into a code to prevent unauthorized access", "A backup system", "A password manager"]',
  'Converting data into a code to prevent unauthorized access',
  'Data Protection',
  'Medium'
),
(
  'What is the most secure way to share sensitive information?',
  '["Send it via regular email", "Use encrypted file sharing", "Post it on social media", "Tell someone in person"]',
  'Use encrypted file sharing',
  'Data Protection',
  'Hard'
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_quiz_attempts_user_id ON quiz_attempts(user_id);
CREATE INDEX idx_quiz_attempts_created_at ON quiz_attempts(created_at);
CREATE INDEX idx_quizzes_category ON quizzes(category);
CREATE INDEX idx_quizzes_difficulty ON quizzes(difficulty);

-- Show the created tables
SHOW TABLES;

-- Show sample data
SELECT 'Users table:' as info;
SELECT id, username, email, created_at FROM users LIMIT 5;

SELECT 'Quiz questions:' as info;
SELECT id, question, category, difficulty FROM quizzes LIMIT 5; 