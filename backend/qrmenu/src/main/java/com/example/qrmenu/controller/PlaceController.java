package com.example.qrmenu.controller;

import com.example.qrmenu.model.Place;
import com.example.qrmenu.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/places")
public class PlaceController {

    @Autowired
    private PlaceService placeService;

    @PostMapping
    public Place createPlace(@RequestBody Place place) {
        System.out.println("Received request to create place: " + place);
        Place savedPlace = placeService.savePlace(place);
        System.out.println("Place saved successfully: " + savedPlace);
        return savedPlace;
    }

    @GetMapping
    public List<Place> getAllPlaces() {
        System.out.println("Received request to fetch all places");
        List<Place> places = placeService.getAllPlaces();
        System.out.println("Fetched places: " + places);
        return places;
    }

    @GetMapping("/{id}")
    public Place getPlaceById(@PathVariable Long id) {
        System.out.println("Received request to fetch place by id: " + id);
        Place place = placeService.getPlaceById(id);
        System.out.println("Fetched place: " + place);
        return place;
    }

    @PutMapping("/{id}")
    public Place updatePlace(@PathVariable Long id, @RequestBody Place place) {
        System.out.println("Received request to update place: " + id);
        Place existingPlace = placeService.getPlaceById(id);
        if (existingPlace != null) {
            existingPlace.setName(place.getName());
            existingPlace.setDescription(place.getDescription());
            existingPlace.setGoogleMapsLink(place.getGoogleMapsLink());
            Place updatedPlace = placeService.savePlace(existingPlace);
            System.out.println("Place updated successfully: " + updatedPlace);
            return updatedPlace;
        } else {
            throw new RuntimeException("Place not found with id: " + id);
        }
    }

    @DeleteMapping("/{id}")
    public void deletePlace(@PathVariable Long id) {
        System.out.println("Received request to delete place by id: " + id);
        placeService.deletePlace(id);
        System.out.println("Place deleted successfully");
    }
}
