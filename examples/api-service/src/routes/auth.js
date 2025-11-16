/**
 * Authentication Routes
 */

const express = require('express');
const router = express.Router();

// POST /api/auth/login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Validate input
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    // Authentication logic would go here
    // For demo purposes, return mock response
    res.status(200).json({
      token: 'mock-jwt-token',
      user: { email, id: 1 }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/auth/register
router.post('/register', async (req, res) => {
  try {
    const { email, password, name } = req.body;

    // Validate input
    if (!email || !password || !name) {
      return res.status(400).json({ error: 'Email, password, and name required' });
    }

    // Registration logic would go here
    res.status(201).json({
      message: 'User created successfully',
      user: { email, name, id: 1 }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
