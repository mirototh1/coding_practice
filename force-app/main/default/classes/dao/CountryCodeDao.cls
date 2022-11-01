/**
 * The Data Access Object representation of the Country Codes data
 */
public with sharing class CountryCodeDao {

    private String name;
    private String alpha2Code;
    private String alpha3Code;
    private String capital;
    private String region;

    public CountryCodeDao setName(final String nameValue) {
        this.name = nameValue;
        return this;
    }

    public String getName() {
        return this.name;
    }
    
    public CountryCodeDao setAlpha2Code(final String alpha2CodeValue) {
        this.alpha2Code = alpha2CodeValue;
        return this;
    }

    public String getAlpha2Code() {
        return this.alpha2Code;
    }
    
    public CountryCodeDao setAlpha3Code(final String alpha3CodeValue) {
        this.alpha3Code = alpha3CodeValue;
        return this;
    }

    public String getAlpha3Code() {
        return this.alpha3Code;
    }
    
    public CountryCodeDao setCapital(final String capitalValue) {
        this.capital = capitalValue;
        return this;
    }

    public String getCapital() {
        return this.capital;
    }
    
    public CountryCodeDao setRegion(final String regionValue) {
        this.region = regionValue;
        return this;
    }

    public String getRegion() {
        return this.region;
    }

    public Integer hashCode() {
        return 17 + (31 * name.hashCode()) + (31 * alpha2Code.hashCode()) + (31 * alpha3Code.hashCode()) + (31 * capital.hashCode()) + (31 * region.hashCode());
    }
}