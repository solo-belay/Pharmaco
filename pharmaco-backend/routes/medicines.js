const express = require('express');
const router = express.Router();

module.exports = (pool) => {
  // GET all medicines
  router.get('/', async (req, res) => {
    try {
      const [medicines] = await pool.query('SELECT * FROM medicines');
      res.json(medicines);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  // POST new medicine
  router.post('/', async (req, res) => {
    try {
      const { name, generic_name, description, manufacturer, category } = req.body;
      
      const [result] = await pool.execute(
        'INSERT INTO medicines (name, generic_name, description, manufacturer, category) VALUES (?, ?, ?, ?, ?)',
        [name, generic_name, description, manufacturer, category]
      );
      
      res.status(201).json({
        message: 'Medicine added successfully',
        medicineId: result.insertId
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  return router;
};