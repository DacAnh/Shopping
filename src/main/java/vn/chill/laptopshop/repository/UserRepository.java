package vn.chill.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.chill.laptopshop.domain.User;
import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByEmail(String email);
    
    boolean existsByEmail(String email);
}
