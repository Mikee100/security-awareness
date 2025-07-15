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
  role VARCHAR(20) NOT NULL DEFAULT 'user',
  verified BOOLEAN NOT NULL DEFAULT FALSE,
  verification_token VARCHAR(255)
);

-- Levels table
CREATE TABLE IF NOT EXISTS levels (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Quiz questions table
CREATE TABLE IF NOT EXISTS quiz_questions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  question TEXT NOT NULL,
  options JSON NOT NULL,
  correct_answer VARCHAR(255) NOT NULL,
  category VARCHAR(100) DEFAULT 'General',
  level_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (level_id) REFERENCES levels(id)
);

-- Quiz attempts table
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  score DECIMAL(5,2) NOT NULL,
  total_questions INT NOT NULL,
  correct_answers INT NOT NULL,
  level_id INT,
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  time_taken INT,
  answers JSON NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (level_id) REFERENCES levels(id)
);



-- Insert standard levels
INSERT INTO levels (name) VALUES ('Easy'), ('Medium'), ('Hard'), ('Expert')
    ON DUPLICATE KEY UPDATE name = VALUES(name);


INSERT INTO quiz_questions (question, options, correct_answer, category, level_id, created_at) VALUES
('What is phishing?', '["A type of malware", "A social engineering attack", "A firewall", "A password manager"]', 'A social engineering attack', 'General', 1, '2025-07-07 15:32:06'),
('Which of the following is a strong password?', '["password123", "123456", "Qw!7$zP@9", "letmein"]', 'Qw!7$zP@9', 'Passwords', 1, '2025-07-07 15:32:06'),
('What does 2FA stand for?', '["Two-Factor Authentication", "Two-Firewall Access", "Twice-Filtered Access", "Two-File Authorization"]', 'Two-Factor Authentication', 'Authentication', 1, '2025-07-07 15:32:06'),
('Which is a common sign of a phishing email?', '["Personalized greeting", "Request for sensitive info", "Proper grammar", "Sent from your own email"]', 'Request for sensitive info', 'Phishing', 2, '2025-07-07 15:32:06'),
('What is ransomware?', '["A type of firewall", "A virus that steals data", "Malware that encrypts files for payment", "A password manager"]', 'Malware that encrypts files for payment', 'Malware', 2, '2025-07-07 15:32:06'),
('What should you do if you receive a suspicious link?', '["Click to check", "Ignore and delete", "Forward to friends", "Reply to sender"]', 'Ignore and delete', 'Phishing', 1, '2025-07-07 15:32:06'),
('Which protocol is secure for web browsing?', '["HTTP", "FTP", "SMTP", "HTTPS"]', 'HTTPS', 'Web', 1, '2025-07-07 15:32:06'),
('What is the main purpose of a firewall?', '["Encrypt data", "Block unauthorized access", "Store passwords", "Scan for viruses"]', 'Block unauthorized access', 'Network', 2, '2025-07-07 15:32:06'),
('What is social engineering?', '["Physical hacking", "Manipulating people to reveal info", "Encrypting files", "Installing malware"]', 'Manipulating people to reveal info', 'General', 2, '2025-07-07 15:32:06'),
('What is the best way to protect sensitive data on a lost laptop?', '["Use a strong password", "Encrypt the hard drive", "Install antivirus", "Disable Wi-Fi"]', 'Encrypt the hard drive', 'Data Protection', 3, '2025-07-07 15:32:06'),
('What does HTTPS stand for?', '["HyperText Transfer Protocol Secure", "HyperText Transfer Protocol Service", "High Transfer Text Protocol Secure", "HyperText Transfer Protocol Standard"]', 'HyperText Transfer Protocol Secure', 'Web', 1, '2025-07-07 16:18:40'),
('Which of the following is a type of malware?', '["Firewall", "Antivirus", "Ransomware", "VPN"]', 'Ransomware', 'Malware', 1, '2025-07-07 16:18:40'),
('What is the main purpose of a strong password?', '["To make it easy to remember", "To prevent unauthorized access", "To share with friends", "To use on all sites"]', 'To prevent unauthorized access', 'Passwords', 1, '2025-07-07 16:18:40'),
('Which device is used to connect a private network to the internet securely?', '["Router", "Firewall", "Switch", "Printer"]', 'Firewall', 'Network', 1, '2025-07-07 16:18:40'),
('What is a common method hackers use to trick people into giving up sensitive information?', '["Phishing", "Patching", "Debugging", "Encrypting"]', 'Phishing', 'Social Engineering', 1, '2025-07-07 16:18:40'),
('What is a VPN primarily used for?', '["Speeding up internet", "Securing network traffic", "Blocking ads", "Downloading files"]', 'Securing network traffic', 'Network', 2, '2025-07-07 16:18:40'),
('Which of the following is NOT a form of multi-factor authentication?', '["Password and SMS code", "Password and fingerprint", "Password and username", "Password and security token"]', 'Password and username', 'Authentication', 2, '2025-07-07 16:18:40'),
('What is the purpose of encryption?', '["To compress data", "To hide data from unauthorized users", "To delete data", "To backup data"]', 'To hide data from unauthorized users', 'Data Protection', 2, '2025-07-07 16:18:40'),
('What is a zero-day vulnerability?', '["A vulnerability that is already patched", "A vulnerability that is unknown to the vendor", "A vulnerability that only affects old systems", "A vulnerability that is not dangerous"]', 'A vulnerability that is unknown to the vendor', 'Vulnerabilities', 2, '2025-07-07 16:18:40'),
('Which of the following is a secure way to store passwords?', '["Plain text", "Hashed and salted", "In a spreadsheet", "In an email"]', 'Hashed and salted', 'Passwords', 2, '2025-07-07 16:18:40'),
('What is the main function of a public key in asymmetric encryption?', '["To decrypt messages", "To encrypt messages", "To store passwords", "To generate random numbers"]', 'To encrypt messages', 'Cryptography', 3, '2025-07-07 16:18:40'),
('Which protocol is used to securely transfer files over the internet?', '["FTP", "SFTP", "HTTP", "SMTP"]', 'SFTP', 'Network', 3, '2025-07-07 16:18:40'),
('What is SQL injection?', '["A type of firewall", "A method to inject code into a database query", "A way to speed up SQL queries", "A backup process"]', 'A method to inject code into a database query', 'Web', 2, '2025-07-07 16:18:40'),
('What is the primary risk of using public Wi-Fi without a VPN?', '["Faster speeds", "Data interception by attackers", "Better connectivity", "Automatic updates"]', 'Data interception by attackers', 'Network', 3, '2025-07-07 16:18:40'),
('What is the purpose of a digital certificate?', '["To encrypt emails", "To verify the identity of a website or user", "To store passwords", "To block malware"]', 'To verify the identity of a website or user', 'Web', 3, '2025-07-07 16:18:40'),
('What is a buffer overflow attack?', '["An attack that fills up disk space", "An attack that exploits memory allocation errors", "An attack that targets network bandwidth", "An attack that deletes files"]', 'An attack that exploits memory allocation errors', 'Exploits', 4, '2025-07-07 16:18:40'),
('Which tool is commonly used for penetration testing?', '["Wireshark", "Nmap", "Photoshop", "Excel"]', 'Nmap', 'Penetration Testing', 4, '2025-07-07 16:18:40'),
('What is the main purpose of a honeypot in cybersecurity?', '["To attract and analyze attackers", "To store sensitive data", "To speed up the network", "To backup files"]', 'To attract and analyze attackers', 'Network', 4, '2025-07-07 16:18:40'),
('What is the difference between symmetric and asymmetric encryption?', '["Symmetric uses one key, asymmetric uses two", "Symmetric is slower", "Asymmetric is less secure", "There is no difference"]', 'Symmetric uses one key, asymmetric uses two', 'Cryptography', 4, '2025-07-07 16:18:40'),
('What is the function of a Security Information and Event Management (SIEM) system?', '["To monitor and analyze security events", "To create firewalls", "To store passwords", "To block spam emails"]', 'To monitor and analyze security events', 'Monitoring', 4, '2025-07-07 16:18:40'),
('What is the safest way to dispose of sensitive documents?', '["Shred them", "Throw in trash", "Recycle", "Burn them in open air"]', 'Shred them', 'Data Protection', 1, '2025-07-15 10:12:50'),
('Which of the following is a sign your computer may be infected with malware?', '["It runs faster", "You see unexpected pop-ups", "Battery lasts longer", "Screen is brighter"]', 'You see unexpected pop-ups', 'Malware', 1, '2025-07-15 10:12:50'),
('What is the main purpose of a password manager?', '["To store passwords securely", "To share passwords", "To create weak passwords", "To delete passwords"]', 'To store passwords securely', 'Passwords', 1, '2025-07-15 10:12:50'),
('What should you do if you receive an unexpected attachment from a known contact?', '["Open it immediately", "Scan it with antivirus", "Forward to others", "Ignore it"]', 'Scan it with antivirus', 'Email Security', 2, '2025-07-15 10:12:50'),
('Which of the following is NOT a good security practice?', '["Regularly updating software", "Using the same password everywhere", "Enabling 2FA", "Locking your screen"]', 'Using the same password everywhere', 'Best Practices', 1, '2025-07-15 10:12:50'),
('What is the purpose of a security patch?', '["To add new features", "To fix security vulnerabilities", "To slow down your device", "To change the UI"]', 'To fix security vulnerabilities', 'Updates', 1, '2025-07-15 10:12:50'),
('What is spear phishing?', '["A broad phishing attack", "A targeted phishing attack", "A type of malware", "A firewall"]', 'A targeted phishing attack', 'Phishing', 2, '2025-07-15 10:12:50'),
('Which of the following is a physical security control?', '["Firewall", "Security badge", "Antivirus", "Encryption"]', 'Security badge', 'Physical Security', 1, '2025-07-15 10:12:50'),
('What is the best way to protect your mobile device?', '["Use a strong passcode", "Disable updates", "Share your device", "Turn off encryption"]', 'Use a strong passcode', 'Mobile Security', 1, '2025-07-15 10:12:50'),
('What is tailgating in security terms?', '["Following someone into a restricted area", "A type of malware", "A network attack", "A password policy"]', 'Following someone into a restricted area', 'Physical Security', 2, '2025-07-15 10:12:50'),
('Which of the following is a privacy risk on social media?', '["Sharing your location publicly", "Using a strong password", "Enabling 2FA", "Logging out after use"]', 'Sharing your location publicly', 'Privacy', 1, '2025-07-15 10:12:50'),
('What is the main risk of using outdated software?', '["Better performance", "Increased vulnerabilities", "More features", "Lower cost"]', 'Increased vulnerabilities', 'Updates', 2, '2025-07-15 10:12:50'),
('What is a brute force attack?', '["Guessing passwords repeatedly", "Encrypting data", "Sending phishing emails", "Scanning for open ports"]', 'Guessing passwords repeatedly', 'Attacks', 2, '2025-07-15 10:12:50'),
('Which of the following is a secure way to connect to a remote office?', '["Public Wi-Fi", "VPN", "Open FTP", "Unencrypted email"]', 'VPN', 'Network', 2, '2025-07-15 10:12:50'),
('What is the function of anti-virus software?', '["To detect and remove malware", "To create backups", "To manage passwords", "To monitor network traffic"]', 'To detect and remove malware', 'Malware', 1, '2025-07-15 10:12:50'),
('What is shoulder surfing?', '["Looking over someone''s shoulder to get information", "Surfing the web securely", "A type of malware", "A password policy"]', 'Looking over someone''s shoulder to get information', 'Social Engineering', 2, '2025-07-15 10:12:50'),
('What is the best way to verify a website is legitimate?', '["Check for HTTPS and a valid certificate", "Look for bright colors", "Check the logo", "See if it loads fast"]', 'Check for HTTPS and a valid certificate', 'Web', 1, '2025-07-15 10:12:50'),
('What is the risk of using public charging stations?', '["Device overheating", "Juice jacking (data theft)", "Faster charging", "Battery damage"]', 'Juice jacking (data theft)', 'Mobile Security', 3, '2025-07-15 10:12:50'),
('What is the purpose of a security awareness training?', '["To educate users about threats", "To install antivirus", "To update software", "To create backups"]', 'To educate users about threats', 'Best Practices', 1, '2025-07-15 10:12:50'),
('What is the main danger of clicking unknown links?', '["Slower internet", "Potential malware or phishing", "Better deals", "More ads"]', 'Potential malware or phishing', 'Phishing', 1, '2025-07-15 10:12:50');