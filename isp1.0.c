class Door {
  public:
  virtual void Lock();
  virtual void Unlock() = 0; 
  virtual bool IsDoorOpen() = 0;
};
