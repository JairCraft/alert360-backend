import { Router } from "express";

const router = Router();

router.get("/users", (req, res) => {
  res.send("main users");
});
router.get("/users/:userId", (req, res) => {
  const { userId } = req.params;
  res.send("get users by id");
});
router.post("/users/save", (req, res) => {
  const jsonReques = JSON.parse(req.body);
  res.send("guardando usuario");
});
router.get("/users", (req, res) => {
  res.send("main users");
});

export default router;
