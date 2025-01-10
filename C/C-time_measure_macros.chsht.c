// KEYWORDS: macro tic toc time measurement clock processor cpu

#ifndef UTILS_H
#define UTILS_H

#include <sys/time.h>
#include <time.h>

#define BILLION 1E+9

/**
 * @brief The start and stop times used by TIC and TOC macros.
 */
struct timespec t_start, t_stop;

// CLOCK_MONOTONIC represents the absolute elapsed wall-clock time since some arbitrary,
// fixed point in the past. It isn't affected by changes in the system time-of-day clock.
// https://stackoverflow.com/a/3527632

/**
 * @brief Get a start time for a time measurement.
 * Uses clock_gettime with CLOCK_MONOTONIC.
 * Should be used with TOC().
 */
#define TIC() clock_gettime(CLOCK_MONOTONIC, &t_start)

/**
 * @brief Get a stop time for a time measurement.
 * Uses clock_gettime with CLOCK_MONOTONIC.
 * Should be used with TIC().
 */
#define TOC() clock_gettime(CLOCK_MONOTONIC, &t_stop)

/**
 * @brief Get a start time for a time measurement.
 * @param CLOCK The clock to use for clock_gettime
 * Should be used with TOC_C().
 */
#define TIC_C(CLOCK) clock_gettime(CLOCK, &t_start)

/**
 * @brief Get a stop time for a time measurement.
 * @param CLOCK The clock to use for clock_gettime
 * Should be used with TIC_C().
 */
#define TOC_C(CLOCK) clock_gettime(CLOCK, &t_stop)

/**
 * @brief Get the time measurement between TIC and TOC, in nanoseconds.
 * @returns double
 */
#define TICTOC_NANOSECONDS ((double)(t_stop.tv_sec - t_start.tv_sec) * BILLION + (double)(t_stop.tv_nsec - t_start.tv_nsec))

/**
 * @brief Get the time measurement between TIC and TOC, in seconds.
 * @returns double
 */
#define TICTOC_SECONDS (TICTOC_NANOSECONDS / BILLION)

#endif