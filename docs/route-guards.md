# Route Guard Logic Specification

This document defines the route guard logic for securing pages within the Next.js application.

## Authentication Guard (`isAuthenticated`)
- **Purpose**: Prevent unauthenticated users from accessing protected routes.
- **Mechanism**:
  - Call `supabase.auth.getSession()` to verify if a session exists.
  - If no session is present, redirect the user to `/auth/login`.
  - If a session exists, allow the requested route to render.
- **Application**: Applies to all routes within `(dashboard)` and each role-specific group (`/coach/*`, `/client/*`, `/admin/*`).

## Role-Based Access Control (`hasRole`)
- **Purpose**: Restrict access based on the user's assigned role (`client`, `coach`, or `admin`).
- **Mechanism**:
  - First ensure the user passes `isAuthenticated`.
  - Fetch the role from `public.profiles` (or session metadata if already loaded).
  - Compare the user role with the required role(s) for the route.
  - If the user does not have the required role, redirect to `/dashboard`.
- **Application**:
  - `/coach/*`: requires role `coach`.
  - `/client/*`: requires role `client`.
  - `/admin/*`: requires role `admin`.
  - Other authenticated routes (`/settings`, `/notifications`, etc.) require only `isAuthenticated`.

## Unauthenticated Route Guard
- **Purpose**: Prevent authenticated users from accessing pages meant only for sign-in or sign-up.
- **Mechanism**:
  - Check `supabase.auth.getSession()`.
  - If a session exists, redirect to `/dashboard`.
  - If no session, allow access to pages such as `/auth/login`, `/auth/signup`, `/auth/forgot-password`, and `/auth/reset-password`.
- **Application**: Applies to all authentication-related pages listed above.

## Implementation Notes
- Middleware is recommended in Next.js to handle server-side redirection before rendering protected pages.
- Custom hooks or higher-order components can be used for client-side checks if needed.
- Global state or React Context may store the user's session and role for easy access across components.
- For a basic MVP, all unauthorized role access should redirect to `/dashboard`. A dedicated "Access Denied" page can be added later if desired.
