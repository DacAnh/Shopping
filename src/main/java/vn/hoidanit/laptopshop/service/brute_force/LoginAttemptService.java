package vn.hoidanit.laptopshop.service.brute_force;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class LoginAttemptService {
    private final int MAX_ATTEMPTS = 3;
    private final long LOCK_TIME_DURATION = 30 * 1000; // 10 giây demo, dùng 60 * 60 * 1000 cho 60 phút

    private final Map<String, Integer> attempts = new ConcurrentHashMap<>();
    private final Map<String, Long> lockTime = new ConcurrentHashMap<>();

    public void loginFailed(String username) {
        int currentAttempts = attempts.getOrDefault(username, 0) + 1;
        attempts.put(username, currentAttempts);

        if (currentAttempts >= MAX_ATTEMPTS) {
            lockTime.put(username, System.currentTimeMillis());
        }
    }

    public void loginSucceeded(String username) {
        attempts.remove(username);
        lockTime.remove(username);
    }

    public boolean isBlocked(String username) {
        if (!lockTime.containsKey(username)) return false;

        long lockedAt = lockTime.get(username);
        if (System.currentTimeMillis() - lockedAt > LOCK_TIME_DURATION) {
            // Unlock
            attempts.remove(username);
            lockTime.remove(username);
            return false;
        }

        return true;
    }
}
