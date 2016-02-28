package org.notarianni;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

public class MiniPricer {

    private final List<DateTime> holidays;

    public MiniPricer() {
        this.holidays = new ArrayList<DateTime>();
    }

    public MiniPricer(List<DateTime> holidays) {
        this.holidays = holidays;
    }

    public double priceAt(DateTime startDate, DateTime priceDate, double initialPrice, double volatility) {
        if (startDate.equals(priceDate)) return initialPrice;

        DateTime nextDay = nextOpenDay(startDate);
        double previousPrice = priceAt(nextDay, priceDate, initialPrice, volatility);
        return previousPrice * (1 + volatility/100);
    }

    private DateTime nextOpenDay(DateTime date) {
        return skipWeekEnd(skipHolidays(date.plusDays(1)));
    }

    private DateTime skipWeekEnd(DateTime date) {
        if(date.getDayOfWeek() ==  5) return date.plusDays(3);
        if(date.getDayOfWeek() ==  6) return date.plusDays(2);
        return date;
    }

    private DateTime skipHolidays(DateTime date) {
        if(holidays.contains(date)) return nextOpenDay(date);
        return date;
    }
}
