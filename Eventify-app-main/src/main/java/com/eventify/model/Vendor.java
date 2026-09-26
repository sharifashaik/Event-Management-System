package com.eventify.model;

public class Vendor {

    public Vendor(Integer vendorId, String vendorName, String category, String description, Double price, Double rating,
            String approvalStatus, String contactEmail, String contactPhone) {
        super();
        this.vendorId = vendorId;
        this.vendorName = vendorName;
        this.category = category;
        this.description = description;
        this.price = price;
        this.rating = rating;
        this.approvalStatus = approvalStatus;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
    }

    public Vendor() {
    }

    private Integer vendorId;
    private String vendorName;
    private String category;
    private String description;
    private Double price;
    private Double rating;
    private String approvalStatus;
    private String contactEmail;
    private String contactPhone;  // ✅ Changed from Integer to String

    public Integer getVendorId() {
        return vendorId;
    }

    public void setVendorId(Integer vendorId) {
        this.vendorId = vendorId;
    }

    public String getVendorName() {
        return vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getContactPhone() {  // ✅ Changed return type
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {  // ✅ Changed parameter type
        this.contactPhone = contactPhone;
    }

    @Override
    public String toString() {
        return "Vendor [vendorId=" + vendorId + ", vendorName=" + vendorName + ", category=" + category
                + ", description=" + description + ", price=" + price + ", rating=" + rating + ", approvalStatus="
                + approvalStatus + ", contactEmail=" + contactEmail + ", contactPhone=" + contactPhone + "]";
    }
}