# MVP Route Tree

This document defines the initial route structure for Phase 0 of the Golf coaching platform. It uses Next.js App Router conventions and assumes Supabase authentication with `public.profiles` providing user roles.

## Unauthenticated Routes

- **Root Landing Page**
  - **Path**: `/`
  - **Component**: `app/page.tsx`
  - **Access**: Public
  - **Description**: Simple welcome page.

- **Login Page**
  - **Path**: `/auth/login`
  - **Component**: `app/(auth)/login/page.tsx`
  - **Access**: Public; redirect authenticated users to `/dashboard`.

- **Signup Page**
  - **Path**: `/auth/signup`
  - **Component**: `app/(auth)/signup/page.tsx`
  - **Access**: Public; redirect authenticated users to `/dashboard`.

- **Forgot Password Page**
  - **Path**: `/auth/forgot-password`
  - **Component**: `app/(auth)/forgot-password/page.tsx`
  - **Access**: Public; redirect authenticated users to `/dashboard`.

- **Reset Password Page**
  - **Path**: `/auth/reset-password`
  - **Component**: `app/(auth)/reset-password/page.tsx`
  - **Access**: Public; requires `code` and `token` query params. Redirect authenticated users to `/dashboard`.

- **Auth Callback Page**
  - **Path**: `/auth/callback`
  - **Component**: `app/(auth)/callback/page.tsx`
  - **Access**: Public (used by Supabase OAuth/email confirmation). Handles session then redirects to `/dashboard` or `/onboarding`.

- **Check Email Page**
  - **Path**: `/auth/check-email`
  - **Component**: `app/(auth)/check-email/page.tsx`
  - **Access**: Public informational page.

- **Legal Pages**
  - **Terms**
    - **Path**: `/legal/terms`
    - **Component**: `app/(public)/legal/terms/page.tsx`
    - **Access**: Public
  - **Privacy**
    - **Path**: `/legal/privacy`
    - **Component**: `app/(public)/legal/privacy/page.tsx`
    - **Access**: Public

## Authenticated Routes

Authenticated pages share the layout `app/(dashboard)/layout.tsx`, which includes the header and sidebar.

- **Dashboard Router**
  - **Path**: `/dashboard`
  - **Component**: `app/(dashboard)/page.tsx`
  - **Access**: Authenticated. Redirects the user to the dashboard for their role (`/client/dashboard`, `/coach/dashboard`, or `/admin/dashboard`).

- **Settings**
  - **Path**: `/settings`
  - **Component**: `app/(dashboard)/settings/page.tsx`
  - **Access**: Authenticated
  - **Description**: User settings page.

- **Notifications**
  - **Path**: `/notifications`
  - **Component**: `app/(dashboard)/notifications/page.tsx`
  - **Access**: Authenticated
  - **Description**: View in-app notifications.

## Role-Specific Routes

Each role uses its own nested layout to enforce role-based access.

### Client

- **Layout**: `app/(client)/layout.tsx`
- **Dashboard**
  - **Path**: `/client/dashboard`
  - **Component**: `app/(client)/dashboard/page.tsx`
  - **Access**: `client` role
  - **Description**: Client activity overview.

### Coach

- **Layout**: `app/(coach)/layout.tsx`
- **Dashboard**
  - **Path**: `/coach/dashboard`
  - **Component**: `app/(coach)/dashboard/page.tsx`
  - **Access**: `coach` role
  - **Description**: Coach activity overview.

### Admin

- **Layout**: `app/(admin)/layout.tsx`
- **Dashboard**
  - **Path**: `/admin/dashboard`
  - **Component**: `app/(admin)/dashboard/page.tsx`
  - **Access**: `admin` role
  - **Description**: Admin activity overview.
- **User Management**
  - **Path**: `/admin/users`
  - **Component**: `app/(admin)/users/page.tsx`
  - **Access**: `admin` role
  - **Description**: Placeholder for managing users.

