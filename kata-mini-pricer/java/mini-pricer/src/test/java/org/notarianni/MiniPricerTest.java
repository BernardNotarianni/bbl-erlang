package org.notarianni;

import org.joda.time.DateTime;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;

public class MiniPricerTest {

    private double initialPrice = 100.0;
    private double volatility = 10.0;

    private DateTime monday = new DateTime(2015,5,4,0,0,0);
    private DateTime tuesday = new DateTime(2015,5,5,0,0,0);
    private DateTime wednesday = new DateTime(2015,5,6,0,0,0);
    private DateTime friday = new DateTime(2015,5,8,0,0,0);
    private DateTime nextMonday = new DateTime(2015,5,11,0,0,0);

    @Test
    public void price_today_is_initial_price () {
        MiniPricer pricer = new MiniPricer();
        double price = pricer.priceAt(monday, monday, initialPrice, volatility);
        assertEquals(initialPrice, price);
    }

    @Test
    public void price_at_one_day () {
        MiniPricer pricer = new MiniPricer();
        double price = pricer.priceAt(monday, tuesday, initialPrice, volatility);
        assertEquals(110.0, price, 0.0001);
    }

    @Test
    public void price_at_two_days () {
        MiniPricer pricer = new MiniPricer();
        double price = pricer.priceAt(monday, wednesday, initialPrice, volatility);
        assertEquals(121.0, price, 0.0001);
    }

    @Test
    public void price_over_weekend () {
        MiniPricer pricer = new MiniPricer();
        double price = pricer.priceAt(friday, nextMonday, initialPrice, volatility);
        assertEquals(110.0, price, 0.0001);
    }

    @Test
    public void price_over_bank_holidays () {
        List<DateTime> holidays = new ArrayList<DateTime>();
        holidays.add(tuesday);
        MiniPricer pricer = new MiniPricer(holidays);
        double price = pricer.priceAt(monday, wednesday, initialPrice, volatility);
        assertEquals(110.0, price, 0.0001);
    }

}
