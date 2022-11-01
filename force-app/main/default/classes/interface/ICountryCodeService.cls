/**
 * This interface provides generic methods for an interaction with a Country Codes provider.
 */
public interface ICountryCodeService {

    List<CountryCodeDao> fetchData();
}