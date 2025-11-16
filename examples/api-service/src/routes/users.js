/**
 * User Routes
 */

const express = require('express');
const router = express.Router();

// GET /api/users
router.get('/', async (req, res) => {
  try {
    // Would fetch from database
    res.status(200).json({
      users: [
        { id: 1, name: 'John Doe', email: 'john@example.com' },
        { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
      ]
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /api/users/:id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;

    // Would fetch from database
    res.status(200).json({
      user: { id: parseInt(id), name: 'John Doe', email: 'john@example.com' }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
