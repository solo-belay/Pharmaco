module.exports = (pool) => {
  const router = require('express').Router();

  // Register new pharmacy
  router.post('/register', async (req, res) => {
    try {
      const { username, email, pharmacy_name, phone, address, license_number } = req.body;
      
      // Basic validation
      if (!username || !email || !pharmacy_name || !license_number) {
        return res.status(400).json({ error: 'Missing required fields' });
      }

      const [result] = await pool.execute(
        `INSERT INTO users 
        (username, email, user_type, pharmacy_name, phone, address, license_number) 
        VALUES (?, ?, 'pharmacy', ?, ?, ?, ?)`,
        [username, email, pharmacy_name, phone, address, license_number]
      );

      res.status(201).json({
        message: 'Pharmacy registered successfully',
        pharmacyId: result.insertId
      });
    } catch (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(400).json({ error: 'Username or email already exists' });
      }
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  // Get all pharmacies
  router.get('/', async (req, res) => {
    try {
      const [pharmacies] = await pool.query(
        `SELECT user_id, pharmacy_name, phone, address 
         FROM users WHERE user_type = 'pharmacy' AND is_approved = TRUE`
      );
      res.json(pharmacies);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  return router;
};