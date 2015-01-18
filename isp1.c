class Door {
  public:
  virtual void Lock();
  virtual void Unlock() = 0; 
  virtual bool IsDoorOpen() = 0;
};

// We want a door that closes after 30s open

class Timer {
  public:
  void Regsiter(int timeout, TimerClient* client);
};

class TimerClient {
  public:
  virtual void TimeOut() = 0;
};
