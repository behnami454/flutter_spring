package com.example.qrmenu.service;

import com.example.qrmenu.model.Place;
import com.example.qrmenu.repository.PlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlaceService {

    @Autowired
    private PlaceRepository placeRepository;

    public Place savePlace(Place place) {
        return placeRepository.save(place);
    }

    public List<Place> getAllPlaces() {
        return placeRepository.findAll();
    }

    public Place getPlaceById(Long id) {
        return placeRepository.findById(id).orElse(null);
    }

    public void deletePlace(Long id) {
        placeRepository.deleteById(id);
    }
}
