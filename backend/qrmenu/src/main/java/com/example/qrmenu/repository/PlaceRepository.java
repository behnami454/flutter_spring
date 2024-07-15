package com.example.qrmenu.repository;

import com.example.qrmenu.model.Place;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaceRepository extends JpaRepository<Place, Long> {
}
