const express = require('express');
const mysql = require('mysql2'); // New: MySQL Driver
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// 1. Connect to WampServer MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      // Default WampServer user
    password: '',      // Default WampServer password (usually empty)
    database: 'emergency_db'
});

db.connect((err) => {
    if (err) {
        console.error('❌ Database connection failed: ' + err.stack);
        return;
    }
    console.log('✅ Connected to WampServer MySQL Database.');
});

// 2. The Emergency Alert Route
app.post('/api/emergency/alert', (req, res) => {
    const { userId, latitude, longitude } = req.body;
    const mapLink = `https://www.google.com/maps?q=${latitude},${longitude}`;

    // 3. PERMANENT LOGGING: Insert into MySQL
    const sql = "INSERT INTO sos_logs (user_id, latitude, longitude, google_maps_link) VALUES (?, ?, ?, ?)";
    const values = [userId, latitude, longitude, mapLink];

    db.query(sql, values, (err, result) => {
        if (err) {
            console.error("❌ Error saving to database:", err);
            return res.status(500).json({ error: "Failed to log emergency" });
        }

        console.log(`🚨 SOS Logged Permanently. ID: ${result.insertId}`);
        
        res.status(200).json({ 
            status: "Success", 
            message: "Emergency logged in database.",
            logId: result.insertId
        });
    });
});

app.post('/api/user/register', (req, res) => {
    const { full_name, age, blood_type, allergies, medications, medical_notes, police, ambulance, fire } = req.body;

    const sql = `INSERT INTO users 
    (full_name, age, blood_type, allergies, medications, medical_notes, police_no, ambulance_no, fire_no) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`;

    const values = [full_name, age, blood_type, allergies, medications, medical_notes, police, ambulance, fire];

    db.query(sql, values, (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(200).json({ message: "User profile created", userId: result.insertId });
    });
});
app.listen(3000, '0.0.0.0', () => {
    console.log('Server running on port 3000');
});